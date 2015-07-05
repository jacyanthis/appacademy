require 'rspec'
require 'array'

describe Array do
  let(:empty_array) { [] }

  describe "#my_uniq" do
    let(:array_with_dups) { [1,2,1,3,3] }

    it "returns an empty array" do
      expect(empty_array.my_uniq).to eq([])
    end

    it "finds unique elements" do
      expect(array_with_dups.my_uniq).to eq([1,2,3])
    end
  end

  describe "#two_sum" do
    let(:array_with_two_sums) { [-1,0,2,-2,1] }
    let(:array_with_no_two_sums) { [1,2,3,4] }

    it "returns no positions if no two_sums" do
      expect(array_with_no_two_sums.two_sum).to eq([])
    end

    it "returns positions of two_sums" do
      expect(array_with_two_sums.two_sum).to eq([[0,4],[2,3]])
    end
  end

  describe "#median" do
    let(:even_array) { [1,2,4,5] }
    let(:odd_array) { [1,2,3,4,5] }

    it "returns average of middle elements in even array" do
      expect(even_array.median).to eq(3)
    end

    it "returns midddle element in odd array" do
      expect(odd_array.median).to eq(3)
    end
  end

  describe "#my_transpose" do
    let(:matrix) { [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
      ] }

    it "transposes the matrix" do
      expect(matrix.my_transpose).to eq([
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8]
        ])
    end
  end
end
