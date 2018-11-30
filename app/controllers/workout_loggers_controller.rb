class WorkoutLoggersController < ApplicationController
  before_action :set_workout_logger, only: [:show, :edit, :update, :destroy]

  # GET /workout_loggers
  # GET /workout_loggers.json
  def index
    @workout_loggers = WorkoutLogger.all
  end

  # GET /workout_loggers/1
  # GET /workout_loggers/1.json
  def show
  end

  # GET /workout_loggers/new
  def new
    @workout_logger = WorkoutLogger.new
  end

  # GET /workout_loggers/1/edit
  def edit
  end

  # POST /workout_loggers
  # POST /workout_loggers.json
  def create
    @workout_logger = WorkoutLogger.new(workout_logger_params)

    respond_to do |format|
      if @workout_logger.save
        format.html { redirect_to @workout_logger, notice: 'Workout logger was successfully created.' }
        format.json { render :show, status: :created, location: @workout_logger }
      else
        format.html { render :new }
        format.json { render json: @workout_logger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workout_loggers/1
  # PATCH/PUT /workout_loggers/1.json
  def update
    respond_to do |format|
      if @workout_logger.update(workout_logger_params)
        format.html { redirect_to @workout_logger, notice: 'Workout logger was successfully updated.' }
        format.json { render :show, status: :ok, location: @workout_logger }
      else
        format.html { render :edit }
        format.json { render json: @workout_logger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workout_loggers/1
  # DELETE /workout_loggers/1.json
  def destroy
    @workout_logger.destroy
    respond_to do |format|
      format.html { redirect_to workout_loggers_url, notice: 'Workout logger was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout_logger
      @workout_logger = WorkoutLogger.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workout_logger_params
      params.require(:workout_logger).permit(:date, :height, :weight, :steps, :activitycalories, :sleepstarttime, :sleependtime)
    end
end
