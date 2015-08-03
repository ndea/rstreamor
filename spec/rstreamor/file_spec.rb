require 'spec_helper'

describe Rstreamor::File do

  subject { Rstreamor::File.new nil }

  it { is_expected.to respond_to :data }
  it { is_expected.to respond_to :content_type }
  it { is_expected.to respond_to :size }
end
