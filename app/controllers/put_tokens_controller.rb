# frozen_string_literal: true
class PutTokensController < ApplicationController
  def create
    put_policy = Qiniu::Auth::PutPolicy.new(Settings.qiniu.bucket, nil, 3600)
    render plain: Qiniu::Auth.generate_uptoken(put_policy)
  end
end
