class IpAddressController < ApplicationController
  before_action :authenticate_user!

  def menu
    @own_address = Ipaddress.where(owner_id: current_user.id)
  end

  def dispense
    
  end

  def submit_dispense
     description = params["description"] || ""
     @ipa = Ipaddress.dispense(current_user.id, description)
     unless @ipa 
       flash[:notice] = "空きIPアドレスがありません。"
     else
       flash[:notice] = @ipa.ip_address + "が払い出されました。"
     end
     redirect_to :action => "menu"
  end

  def delete
  end

  def submit_delete
    unless params["ip_address_id"]
      @message = "該当のIPアドレスがありません。"
      redirect_to :action => "menu"
    end

    @ip = Ipaddress.where(id: params["ip_address_id"].to_i).first
    result = @ip.refund(current_user.id)
    if result
      flash[:notice] = @ip.ip_address + "を払い戻しました。"
    else
      flash[:notice] = "該当のアドレスの払い戻しができませんでした。"
    end
    redirect_to :action => "menu"

  end

end
