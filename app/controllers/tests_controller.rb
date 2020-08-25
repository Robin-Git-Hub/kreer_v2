# frozen_string_literal: true

class TestsController < ApplicationController
  def index
    @tests = Test.all
  end

  def take
    @test = Test.find(params[:test_id])
    @questions = @test.questions
  end

  def result
    @candidate = User.find(params[:user_id])
    @test = Test.find(params[:test_id])
  end

  def show
    @test = Test.find(params[:id])
    @questions = @test.questions
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)
    @test.tag_list = params[:test][:tag_list].keys
    @test.user = current_user
    if @test.save
      redirect_to test_path(@test), notice: 'Your test has been successfully generated!'
    else
      render :new
    end
  end

  private

  def test_params
    params.require(:test).permit(:name, :jobtype)
  end
end
