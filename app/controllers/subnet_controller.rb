class SubnetController < ApplicationController

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
      flash[:notice]  =  "登録に失敗しました。" 
    end
    redirect_to :action => "menu"
  end

  def delete
    result = Subnet.where(params["subnet_id"]).first.unregister
    if result
      flash[:notice] = "削除しました。" 
    else
      flash[:notice] = "削除に失敗しました。" 
    end
    redirect_to :action => "menu"
  end

  def list
    @subnet = Subnet.all
  end

  def ip_list
    unless params["subnet_id"]
      flash[:notice] = "該当のサブネットがありません。"
      redirect_to action => "menu"
    end

    @subnet = Subnet.where(params["subnet_id"]).first
    unless @subnet
      flash[:notice] = "該当のサブネットがありません。"
      redirect_to action => "menu"
    else
  #    @ipaddresses = @subnet.ipaddresses
    end
    


  end
end
