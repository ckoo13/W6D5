class CatsController < ApplicationController
    def index 
        @cats = Cat.all 
        render 'index'
    end

    def show
        @cat = Cat.find_by(id: params[:id])

        render 'show'
    end

    #the actual controller action to create a new cat instance
    def create
        @cat = Cat.new(cat_params)
        @cat.age = @cat.calculate_age(cat_params[:birth_date])

        if @cat.save
            redirect_to cat_url(@cat)
        else
            rendor json: @cat.errors.full_message, status: :unprocessable_entity
        end
    end

    #GET request to the form where you can create a new cat
    def new
        render 'new'
    end

    #GET request to the form where you can edit a cat
    def edit
        @cat = Cat.find_by(id: params[:id])
        render 'edit'
    end

    #actual controller action to edit the cat
    def update
        @cat = Cat.find_by(id: params[:id])

        @cat.age = @cat.calculate_age(cat_params[:birth_date])

        if @cat.update(cat_params)
            redirect_to cat_url(@cat)
        else
            render :edit
        end
    end

    private
    
    def cat_params
        params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
    end
end