class MailEngine::MailTemplatesController < ApplicationController
  before_filter :find_model

  def index
    @mail_templates = MailEngine::MailTemplate.all
  end

  def show
  end

  def destroy
    @mail_template.destroy
    redirect_to mail_engine_mail_templates_path
  end

  def create
    @mail_template = MailTemplate.new(params[:mail_engine_mail_template])
    if @mail_template.save
      redirect_to(@mail_template, :notice => 'Mail template was successfully created.')
    else
      render "new"
    end
  end

  def new
    @mail_template = MailTemplate.new
  end

  def update
    if @mail_template.update_attributes(params[:mail_engine_mail_template])
      redirect_to(@mail_template, :notice => 'Mail template was successfully created.')
    else
      render "new"
    end
  end

  def edit
  end

  private
  def find_model
    @mail_template = MailTemplate.find(params[:id]) if params[:id]
  end
end