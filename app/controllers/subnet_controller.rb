class SubnetController < ApplicationController
  before_action :authenticate_admin_user!

  def menu
    @subnets = Subnet.all
  end

  def register
  end

  def submit_register
    result = Subnet.register(params["subnet"], params["mask"], params["description"])
    if result
      flash[:notice]  =  "登録に成功しました。" 
    else
      flash[:alert]  =  "登録に失敗しました。" 
    end
    redirect_to :action => "menu"
  end

  def delete
    result = Subnet.where(params["subnet_id"]).first.unregister
    if result
      flash[:notice] = "削除しました。" 
    else
      flash[:alert] = "削除に失敗しました。" 
    end
    redirect_to :action => "menu"
  end

  def list
    @subnet = Subnet.all
  end

  def ip_list
    unless params["subnet_id"]
      flash[:alert] = "該当のサブネットがありません。"
      redirect_to action => "menu"
    end

    @subnet = Subnet.where(id: params["subnet_id"]).first

    unless @subnet
      flash[:alert] = "該当のサブネットがありません。"
      redirect_to :action => "menu"
    end
    
    @users = User.all.index_by(&:id)
  end
end
