require "../spec_helper"

describe LazyCode::Carcin do
  it "returns sdtout" do
    LazyCode::Carcin.new.run_request("crystal", "0.35.0", %(puts "Hello, world!"))
      .should eq "Hello, world!\n"
  end

  it "returns stderr" do
    LazyCode::Carcin.new.run_request("crystal", "0.35.0", "1//0")
      .lines.first.includes?("DivisionByZeroError").should be_true
  end

  it "raises on server errors" do
    expect_raises(LazyCode::Errors::ServerError, "unsupported version") do
      LazyCode::Carcin.new.run_request("crystal", "123456", %(puts "Hello, world!"))
    end
  end
end
