class NumbersController < ApplicationController
  DEFAULT_COUNT = 10

  def index
    count = params[:count] ||= DEFAULT_COUNT
    @numbers = count.to_i.times.map { rand(1...100) }
  end
end
