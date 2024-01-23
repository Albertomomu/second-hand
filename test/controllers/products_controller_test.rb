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
  test 'render a new product form' do
    get new_product_path
    assert_response :success
    assert_select 'form'
  end
  test 'allow to create a new product' do
    post products_path, params: {
      product: {
        title: 'play 4',
        description: 'rota',
        price: '20$'
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Your product was added correctly'
  end
  test 'Does not allow to create a new product with empty fields' do
    post products_path, params: {
      product: {
        title: 'play 4',
        description: 'rota',
        price: ''
      }
    }
    assert_response :unprocessable_entity
  end
  test 'render update product form' do
    get edit_product_path(products(:switch))
    assert_response :success
    assert_select 'form'
  end
  test 'allow to update a product' do
    patch product_path(products(:switch)), params: {
      product: {
        price: 165
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Your product was updated correctly'
  end
  test 'Does not allow to update a product with empty fields' do
    patch product_path(products(:switch)), params: {
      product: {
        price: nil
      }
    }
    assert_response :unprocessable_entity
  end
  test 'allow to delete a product' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:switch))
    end
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Your product was deleted correctly'
  end
end