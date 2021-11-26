class NotesController < ApplicationController
  def index
    @notes = Note.where(user_id: current_user)
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user
    if @note.save
      redirect_to notes_path
    else
      render :new
    end
  end

  def show
     @note = Note.find(params[:id])
  end

  def destroy
    @note = Note.find(params[:id])
    @note.delete
    redirect_to notes_path
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    @note.update(note_params)
    redirect_to notes_path
  end

  private

  def note_params
    params.require(:note).permit(:content, :date)
  end
end
