class UserFilesController < ApplicationController
  before_action :set_user_file, only: [:show, :edit, :update, :destroy]

  # GET /user_files
  # GET /user_files.json
  def index
    @user_files = UserFile.all
  end

  # GET /user_files/1
  # GET /user_files/1.json
  def show
  end

  # GET /user_files/new
  def new
    @user_file = UserFile.new
  end

  # POST /user_files
  # POST /user_files.json
  def create
    @user_file = UserFile.find_by_name(params["user_file"]["name"])
    @user_file.destroy if @user_file

    # Create a new user_file
    @user_file = UserFile.new(user_file_params)

    respond_to do |format|
      if @user_file.save
        format.html { redirect_to @user_file, notice: 'User file was successfully uploaded.' }
        format.json { render :show, status: :created, location: @user_file }
      else
        format.html { render :new }
        format.json { render json: @user_file.errors, status: :unprocessable_entity }
      end
    end

    # Queue the file for processing by ActiveJob
    UserFileImportJob.set(wait: 5.seconds).perform_later @user_file
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_file
      @user_file = UserFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_file_params
      params.require(:user_file).permit(:name, :csv_file)
    end
end
