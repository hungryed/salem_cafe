require 'spec_helper'

require 'carrierwave/test/matchers'

describe FoodPhotoUploader do
  include CarrierWave::Test::Matchers

  let(:uploader) do
    FoodPhotoUploader.new(FactoryGirl.build(:food))
  end

  let(:path) { Rails.root.join('spec/file_fixtures/burger.jpg') }

  before do
    FoodPhotoUploader.enable_processing = true
  end

  after do
    FoodPhotoUploader.enable_processing = false
  end

  it "stores without error" do
    expect(lambda { uploader.store!(File.open(path)) }).to_not raise_error
  end
end
