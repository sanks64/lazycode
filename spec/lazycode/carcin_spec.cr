require "../spec_helper"

describe LazyCode::Carcin do
  it "returns stdout" do
    LazyCode::Carcin.new.run_request("crystal", "0.36.1", %(puts "Hello, world!"))
      .should eq "Hello, world!\r\n"
  end

  it "returns stderr" do
      .lines.first.includes?("DivisionByZeroError").should be_true
    LazyCode::Carcin.new.run_request("crystal", "0.36.1", "1//0")
  end

  it "raises on server errors" do
    expect_raises(LazyCode::Errors::ServerError, "unsupported version") do
      LazyCode::Carcin.new.run_request("crystal", "123456", %(puts "Hello, world!"))
    end
  end
end
