class ProductsController < ApplicationController
  def index
    @products = Product.all.with_attached_photo
  end
  def show
    product
  end
  def new
    @product = Product.new
  end
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: "Your product was added correctly"
    else 
      render :new, status: :unprocessable_entity
    end
  end
  def edit
    product
  end
  def update
    if product.update(product_params)
      redirect_to products_path, notice: "Your product was updated correctly"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    product.destroy
    redirect_to products_path, notice: "Your product was deleted correctly"
  end

private
def product_params
  params.require(:product).permit(:title, :description, :price, :photo)
end

def product
  @product = Product.find(params[:id])
end

end