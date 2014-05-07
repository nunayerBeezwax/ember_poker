class TableController < ApplicationController
  def index
    @table = Table.all
    render :json => @table
  end

  def create
    @table = table.new(table_params)
    if @table.save
      render :json => @table, :status => 201
    else
      render :json => @table.errors, :status => 422
    end
  end

  def show
    @table = Table.find(params[:id])
    render :json => @table
  end

  def update
    @table = Table.find(params[:id])
    if @table.update(table_params)
      head :no_content
    else
      render :json => @table.errors, :status => 422
    end
  end

  def destroy
    @table = Table.find(params[:id])
    @table.destroy
    head :no_content
  end

private

  def table_params
    params.fetch(:table).permit(:players, :dealer, :board, :hands, :pot, :button,
     :active_players, :sb, :bb, :action, :current_bet)
  end
end
