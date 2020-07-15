class NewsController < ApplicationController

    before_action :require_user, except: [:index]

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
        @newsitem.user = current_user
        if @newsitem.save
            puts "Yes it was saved"
            flash[:success] = "Julkaistettu onnistuneesti"
            redirect_to root_path
        else
            puts 'Not saved'
            render 'new'
            flash[:warning] = "Virhe. Viesti ei ole tallennetu"
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
        if @itemid.user == current_user
            @itemid.update(title: params[:new][:title], description: params[:new][:description])
            if @itemid.save
                flash[:success] = "Päivitetty onnistuneesti"
            else
                flash[:warning] = "Virhe. Viesti ei ole päivitetty!"
            end
            redirect_to root_path
        else
            flash[:danger] = "Estetty. Ei ole oikeuksia."
            redirect_to edit_news_path
        end
    end

    def edit
        if @itemid.user != current_user
            flash[:danger] = "Estetty. Ei ole oikeutta."
            redirect_to root_path
        end
    end

    def show
    end

    def destroy
        if @itemid.user == current_user
            if @itemid.destroy
                flash[:success] = "Viesti oli poistettu"
                redirect_to root_path
            else
                flash[:danger] = "Virhe. Viesti ei ole poistettu!"
                redirect_to root_path
            end
        else
            flash[:danger] = "Estetty. Poistaminen ei onnistunut. Ei ole käyttöoikeuksia."
        end
    end


    private
        def news_params
            puts "editing parameters"
            params.permit(:title, :description)
            puts "parameters pass. Good"
        end

    
end
