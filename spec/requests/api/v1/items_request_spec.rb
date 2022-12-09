require 'rails_helper'

describe 'Items API' do 
  it 'sends a list of Items' do 
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)
      
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end
  it 'can get one item by its id' do 
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_an(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
  end

  it 'can create a new item' do 

    id = create(:merchant).id
    item1 = ({ name: "Mod 3 Instructor Cheat Sheet", 
                     description: "Answers to all questions and tests",
                     unit_price: 300.00,
                     merchant_id: id 
                  })

    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item1)

    created_item = Item.first

    expect(response).to be_successful
    expect(created_item.name).to eq(item1[:name])
    expect(created_item.description).to eq(item1[:description])
    expect(created_item.unit_price).to eq(item1[:unit_price])
    expect(created_item.merchant_id).to eq(item1[:merchant_id])
      
  end

  it 'can update an existing item' do 
    merchant = create(:merchant).id
    item_id = create(:item).id
    previous_name = Item.last.name
    
    item1 = ({ name: "Mod 3 Instructor Cheat Sheet", 
              description: "Answers to all questions and tests",
              unit_price: 300.00,
              merchant_id: merchant 
            })

            
            # new_item_name = { name: "Jeff's Private school info"} 
            headers = { "CONTENT_TYPE" => "application/json" }

    patch "/api/v1/items/#{item_id}", headers: headers, params: JSON.generate({item: item1})

    item = Item.find_by(id: item_id )

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Mod 3 Instructor Cheat Sheet")

  end


end