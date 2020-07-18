# seeds here
{
  sugar: 50,
  oil: 10,
  arroz: 100,
  beans: 100,
  meat: 150
}.each do |product, quantity|
  ProductBatch.create!(product: product, batch_size: quantity)
end
