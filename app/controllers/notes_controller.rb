class NotesController < ApplicationController

  def api
  end

  def index
    @notes = Note.all
    render json: @notes
  end

  def create
    @note = Note.new(params.require(:note).permit(:title, :body))
    @note.save
    render json: @note
  end

  def show
    @note = Note.find(params[:id])
    render json: @note
  end

  def update
    @note = Note.find(params[:id])
    @note.update(params.require(:note).permit(:title, :body))
    render json: @note
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    head :no_content
  end

end
