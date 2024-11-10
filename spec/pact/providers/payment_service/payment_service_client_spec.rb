require 'sbmt/pact/rspec'
require 'payment_service_client'

RSpec.describe PaymentServiceClient, :pact do
  has_http_pact_between 'PaymentServiceClient', 'PaymentService'
  let(:interaction) { new_interaction }
  let(:host) { 'http://localhost:3000' }

  context 'given a valid payment method' do
    let(:valid_payment_method) { '1111222233334444' }
    let(:response_body) { { status: :valid } }
    let(:interaction) do
      super()
        .upon_receiving('a request for validating a payment method')
        .with_request(
                :get,
                "/validate-payment-method/#{valid_payment_method}"
              )
        .with_response(
          200,
          body: response_body
        )
    end
    it 'the call to payment service returns a payment status response with status equal to valid' do
      puts pact_config.inspect
      pact_config.instance_variable_set(:@mock_port, 4567)
      interaction.execute do |_mock_server|
        expect(subject.validate(valid_payment_method)).to eql({ 'status' => 'valid' })
      end
    end
  end
  context "given a black listed payment method" do
    let(:invalid_payment_method) { "9999999999999999" }
    let(:response_body) do { status: :fraud } end
    let(:interaction) do
      super()
      .given("a black listed payment method")
      .upon_receiving("a request for validating the payment method")
      .with_request(
                :get,
                "/validate-payment-method/#{invalid_payment_method}"
              )
        .with_response(
          200,
          body: response_body
        )
    end
    it "the call to payment service returns a payment status response with status equal to fraud" do
      pact_config.instance_variable_set(:@mock_port, 4567)
      interaction.execute do |_mock_server|
        expect(subject.validate(invalid_payment_method)).to eql({ "status" => "fraud" })
      end
    end
  end
end
