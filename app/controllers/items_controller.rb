class ItemsController < ApplicationController
  before_filter :save_last_server, only: [:index]

  def index
    if params[:query]
      @items = Item.paginated_search(params[:query], params)
    end
  end

  def show
    @item = Item.find(params[:id])
    @products = @item.products.includes(:shop).from_server(current_server).separate.recent.limit(5)
    pack_ids = Shop.packed.from_server(current_server).with_item(@item).recent.limit(10).pluck('shops.id')
    @packs = Shop.includes(:products).find(pack_ids)
  end

  private

  def save_last_server
    if cookies[:server_id] != current_server.id
      cookies[:server_id] = { value: current_server.id, expires: 10.years.from_now } 
    end
  end
end
