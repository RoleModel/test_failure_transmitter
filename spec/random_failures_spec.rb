RSpec.describe "A spec with random failures" do
  it "has a 3 out of 10 chance of failing" do
    expect(1..7).to cover Random.rand(1..10)
  end

  it "has a 1 out of 10 chance of failing" do
    expect(1..9).to cover Random.rand(1..10)
  end

  specify "some examples always pass" do
  end
end
