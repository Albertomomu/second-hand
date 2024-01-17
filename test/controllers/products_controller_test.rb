require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path
    assert_response :success
    assert_select '.product', 2
  end
  test 'render a detailed product page' do
    get product_path(products(:switch))
    
    assert_response :success
    assert_select '.title', 'Nintendo Switch'
    assert_select '.description', 'Falla el lector de tarjeta SD'
    assert_select '.price', '195$'
  end
end