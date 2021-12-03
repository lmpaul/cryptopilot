class NotesController < ApplicationController
  def index
    if params[:notes_date]
      @notes = Note.where("date < :from AND date < :to", { from: params[:notes_date][:date_from].to_date, to: params[:notes_date][:date_to].to_date })
      @notes = @notes.where(user_id: current_user)
    else
      @notes = Note.where(user_id: current_user)
    end
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
    @transactions = Transaction.where(date: @note.date)
    @user_transactions = []
    @transactions.each do |transaction|
      if transaction.dashboard.user_id == current_user.id
        @user_transactions << transaction
      end
    end
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
    redirect_to note_path(@note)
  end

  private

  def note_params
    params.require(:note).permit(:content, :date)
  end
end
