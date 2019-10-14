class TodosController < ApplicationController
  before_action :authenticate_user!

  def index
    begin
      @user = current_user
      @todo = @user.todos.all

    rescue StandardError => e
      print e.message
    end
  end

  def new
    begin
      @user = current_user
      @todo = @user.todos.new

    rescue StandardError => e
      print e.message
    end
  end

  def edit
    begin
      @user = current_user
      @todo = @user.todos.find(params[:id])

    rescue StandardError => e
      print e.message
    end
  end

  def create
    begin
      @user = current_user
      @todo = @user.todos.new(todo_params)

      if @todo.save
        redirect_to todos_path
      else
        render 'new'
      end

    rescue StandardError => e
      print e.message
    end
  end

  def update
    begin
      @user = current_user
      @todo = @user.todos.find(params[:id])

      if @todo.update(todo_params)
        redirect_to todos_path
      else
        render 'edit'
      end

    rescue StandardError => e
      print e.message
    end
  end

  def destroy
    begin
      @user = current_user
      @todo = @user.todos.find(params[:id])
      @todo.destroy

      redirect_to todos_path

    rescue StandardError => e
      print e.message
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :completed, :editing)
  end
end
