class MessageConsumer
  ITEM_CATEGORIES = {
    sugar: /acucar/i,
    oil: /oleo/i,
    arroz: /arroz/i,
    beans: /feijao/i,
    meat: /carne/i
  }.freeze

  def initialize(payload)
    @payload = payload.with_indifferent_access
  end

  def process
    {
      user: user,
      products: build_item_payload(items(message_text))
    }
  end

  def build_item_payload(items)
    items.map do |item_data|
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

  def user
    @user ||= @payload.dig(:message, :from)
  end

  def message_text
    @message_text ||= 
      @payload[:message][:contents].find { |content| 
        content[:type] == "text" 
      }.dig(:text)
  end
end
