module Zenvia
  class OrderMessageHandler
    ITEM_CATEGORIES = {
      sugar: /acucar/i,
      oil: /oleo/i,
      arroz: /arroz/i,
      beans: /feijao/i,
      meat: /carne/i
    }.freeze

    def call(sender_phone, message_text)
      user = User.find_or_create_by(phone_number: sender_phone)

      {
        user: user,
        orders: build_orders(user, message_text)
      }
    end

    def build_orders(user, message_text)
      build_item_payload(items(message_text)).map do |item|
        product_batch = ProductBatch.find_by(product: item[:product])

        Order.create!(
          product: item[:product],
          quantity: item[:quantity],
          user: user,
          product_batch: product_batch
        )
      end
    end

    def build_item_payload(items)
      items.drop(1).map do |item_data|
        {
          product: product_category(item_data[0]),
          quantity: item_data[1]
        }
      end
    end

    def product_category(item_text)
      ITEM_CATEGORIES.each do |category, regex|
        return category if regex.match(item_text.parameterize)
      end

      item_text
    end

    def items(message_text)
      message_text
        .split("\n")
        .map { |line| line.split(',').map(&:strip) }
    end
  end
end
