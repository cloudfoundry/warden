require "spec_helper"
require "warden/protocol/copy_in"

describe Warden::Protocol::CopyInReq do
  it_should_behave_like "wrappable request"

  subject do
    described_class.new(
      :handle => "handle",
      :src_path => "/src",
      :dst_path => "/dst",
    )
  end

  field :handle do
    it_should_be_required
    it_should_be_typed_as_string
  end

  field :src_path do
    it_should_be_required
    it_should_be_typed_as_string
  end

  field :dst_path do
    it_should_be_required
    it_should_be_typed_as_string
  end

  it "should respond to #create_reply" do
    subject.create_reply.should be_a(Warden::Protocol::CopyInRep)
  end
end

describe Warden::Protocol::CopyInRep do
  it_should_behave_like "wrappable reply"
end
