# encoding: utf-8

class CategoriesController < ApplicationController
  before_filter :require_admin

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
    @answer = Answer.find(params['parent']) if params['parent']
    @category.answers << @answer if @answer
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:success] = "Kategorie angelegt"
      redirect_to @category
    else
      render 'new'
    end
  end


  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:success] = "Kategorie aktualisiert"
      redirect_to @category
    else
      render 'edit'
    end
  end


  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:success] = "Kategorie gelöscht"
    else
      flash[:error] = "Konnte Kategorie nicht löschen. Details vermutlich in den Logs."
    end
    redirect_to categories_path
  end
end
