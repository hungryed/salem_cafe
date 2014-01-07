class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      ContactForm.receipt(@contact).deliver
      redirect_to root_path, notice: 'Your form has been submitted successfully'
      return true
    else
      render :new
    end
  end

  protected
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email,
        :description, :subject)
  end
end
