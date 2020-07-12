class NewsController < ApplicationController

    before_action :set_item, only: [:update, :edit, :show, :destroy]

    def index
        @newsitems = New.order("created_at DESC")
    end

    def set_item
        @itemid = New.find(params[:id])
    end

    def new
        @newsitem = New.new
    end
 
    def create
        @newsitem = New.new(news_params)
        if @newsitem.save
            puts "Yes it was saved"
            redirect_to root_path
        else
            render new
        end
    end


    def update
        puts @itemid.title
        puts @itemid.description
        puts 'New data:'
        puts params[:new][:title]
        puts params[:new][:description]
        puts 'Json string'
        puts params[:new]
        @itemid.update(title: params[:new][:title], description: params[:new][:description])
        @itemid.save
        redirect_to root_path
    end

    def edit
    end

    def show
    end

    def destroy
        @itemid.destroy
        flash.now[:notice] = "Item oli poistettu"
        redirect_to root_path
    end


    private
        def news_params
            puts "editing parameters"
            params.permit(:title, :description)
            puts "parameters pass. Good"
        end

    
end
