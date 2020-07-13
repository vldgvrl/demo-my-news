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
        @newsitem = New.new(title: params[:title], description: params[:description])
        if @newsitem.save
            puts "Yes it was saved"
            flash[:notice] = "Item oli tallennetu"
            redirect_to root_path
        else
            puts 'Not saved'
            flash[:alert] = "Item ei ole tallennetu"
            redirect_to root_path
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
        if @itemid.save
            flash[:notice] = "Uutinen on päivitetty"
        else
            flash[:alert] = "Uutinen ei ole päivitetty!"
        end
        redirect_to root_path
    end

    def edit
    end

    def show
    end

    def destroy
        if @itemid.destroy
            flash[:notice] = "Item oli poistettu"
            redirect_to root_path
        else
            flash[:alert] = "Item ei ole poistettu"
            redirect_to root_path
        end
    end


    private
        def news_params
            puts "editing parameters"
            params.permit(:title, :description)
            puts "parameters pass. Good"
        end

    
end
