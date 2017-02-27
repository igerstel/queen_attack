require "rspec"
require "queen_attack"

describe QueenAttack do
  describe '#validate_coords' do
    it 'returns true for valid coordinates' do
      input = "4, 4"
      expect(QueenAttack.validate_coords(input)).to eq([true, 'ok', {row:4, col:4}])
    end
    it 'returns false for out of range coordinates' do
      input = "0, 4"
      expect(QueenAttack.validate_coords(input)).to eq([false, 'Coordinates must be between 1 and 8.'])
    end
    it 'returns false for non-numerical coordinates' do
      input = "a, 4"
      expect(QueenAttack.validate_coords(input)).to eq([false, 'Coordinates must be between 1 and 8.'])
    end
    it 'returns false for a single coordinate' do
      input = "4"
      expect(QueenAttack.validate_coords(input)).to eq([false, 'Coordinates must be split with one comma.'])
    end
  end

  describe '#get_coords' do
    it 'returns row/col hash for valid coordinates' do
      allow(STDIN).to receive(:gets).and_return('4, 4')
      expect(QueenAttack.get_coords('white')).to eq({row:4, col:4})
    end
  end

  describe '#initialize' do
    before do
      @q = QueenAttack.new({row:1, col:1}, {row:2, col:2})
    end
    it 'creates an 8x8 board' do
      expect(@q.instance_variable_get(:@board).count).to eq(8)
      expect(@q.instance_variable_get(:@board)[7].count).to eq(8)
    end
    it 'sets row and col hashes for white and black queens' do
      expect(@q.instance_variable_get(:@wq)).to eq({row:1, col:1})
      expect(@q.instance_variable_get(:@bq)).to eq({row:2, col:2})
    end
  end

  describe '#attack_row?' do
    it 'returns true if bq and wq are on the same row' do
      q = QueenAttack.new({row:1, col:1}, {row:1, col:5})
      expect(q.attack_row?).to eq(true)
    end
    it 'returns false if bq and wq are not on the same row' do
      q = QueenAttack.new({row:1, col:1}, {row:2, col:5})
      expect(q.attack_row?).to eq(false)
    end
  end

  describe '#attack_col?' do
    it 'returns true if bq and wq are on the same column' do
      q = QueenAttack.new({row:1, col:1}, {row:5, col:1})
      expect(q.attack_col?).to eq(true)
    end
    it 'returns false if bq and wq are not on the same row' do
      q = QueenAttack.new({row:1, col:1}, {row:2, col:2})
      expect(q.attack_col?).to eq(false)
    end
  end

  describe '#attack_diag?' do
    context 'returns true if bq and wq are on a diagonal' do
      it 'returns true on [1,1], [2,2]' do
        q = QueenAttack.new({row:1, col:1}, {row:2, col:2})
        expect(q.attack_diag?).to eq(true)
      end
      it 'returns true on [4,8], [6,6]' do
        q = QueenAttack.new({row:4, col:8}, {row:6, col:6})
        expect(q.attack_diag?).to eq(true)
      end
    end
    context 'returns false if bq and wq are not on a diagonal' do
      it 'returns true on [1,1], [1,2]' do
        q = QueenAttack.new({row:1, col:1}, {row:1, col:2})
        expect(q.attack_diag?).to eq(false)
      end
      it 'returns true on [4,8], [3,6]' do
        q = QueenAttack.new({row:4, col:8}, {row:3, col:6})
        expect(q.attack_diag?).to eq(false)
      end
    end
  end
end
