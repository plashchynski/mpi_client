require File.dirname(__FILE__) + '/../spec_helper'

MPI.server_url = 'http://192.168.65.11/xml'

describe 'test of verification request' do
  it "should have status 'N'" do
    req = MPI::Verification::Request.new(request_params(:card_number => '4200000000000000'), '1')
    response = req.process
    response.status.should == 'N'
  end

  it "should return 'Y' and url" do
    req = MPI::Verification::Request.new(request_params(:card_number => '4012001037141112'), '2')
    response = req.process
    response.status.should == 'Y'
    response.url.should_not be_empty
  end

  def request_params(new_params)
    { :account_id       => '0'*32,
      :amount           => '100',
      :card_number      => '4200000000000000',
      :description      => 'Test order',
      :display_amount   => '1 USD',
      :currency         => '840',
      :exp_month        => '12',
      :exp_year         => '16',
      :termination_url  => 'http://termurl.com'
    }.update(new_params)
  end
end
