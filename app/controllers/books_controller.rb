class BooksController < ApplicationController
	before_action :authenticate_user!

	def show
		@book = Book.find(params[:id])
		@user = @book.user
		@bookn = Book.new
	end

	def create
		@bookn = Book.new(book_params)
		@bookn.user_id = current_user.id
  		@bookn.save
    	if @bookn.save(book_params)
       		flash[:notice] = "You have created book successfully."
  			redirect_to book_path(@bookn.id)
  		else

  			@books = Book.all
  			@user = current_user
      		render "books/index"
  		end
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user.id != current_user.id
			redirect_to books_path
		end
	end

	def index
		@books = Book.all
		@user = current_user
		@bookn = Book.new
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	def update
		@book = Book.find(params[:id])
    	@book.update(book_params)
    	if @book.update(book_params)
       		flash[:notice] = "You have updated book successfully."
       		redirect_to book_path(@book.id)
    	else
      		@books = Book.all
      		render "books/edit"
    	end
	end

	private
  def book_params
      params.require(:book).permit(:title, :body)
  end
end
