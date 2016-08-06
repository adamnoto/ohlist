require 'spec_helper'

describe Ohlist do
  it 'has a version number' do
    expect(Ohlist::VERSION).not_to be nil
  end

  describe '#foldr' do
    context 'given block' do
      it 'can fold numbers' do
        total = Ohlist.foldr([1,2,3], 0) do |el, acc|
          el + acc
        end
        expect(total).to eq 6
      end # can fold numbers

      it 'can fold string' do
        name = Ohlist.foldr(['Adam', 'Pahlevi', 'Baihaqi'], '') do |name, str|
          str + "#{name} "
        end
        expect(name).to eq 'Adam Pahlevi Baihaqi '
      end
    end # given block

    context 'given lambda' do
      it 'can fold numbers' do
        summer = -> (el, acc) { el + acc }
        total = Ohlist.foldr([1, 2, 3], 0, summer)
        expect(total).to eq 6
      end # fold number

      it 'can fold string' do
        concatr = -> (name, str) { str + "#{name} " }
        name = Ohlist.foldr(['Adam', 'Pahlevi', 'Baihaqi'], '', concatr)
        expect(name).to eq 'Adam Pahlevi Baihaqi '
      end # fold a string
    end # given proc
  end # foldr

  describe '#foldl' do
    context 'given block' do
      it 'can fold numbers' do
        result = Ohlist.foldl([4, 6], 48) do |el, acc|
          acc / el
        end
        expect(result).to eq 2
      end

      it 'can fold string' do
        result = Ohlist.foldl(['Adam', 'Pahlevi', 'Baihaqi'], '') do |name, str|
          "#{str}#{name} "
        end
        expect(result).to eq 'Baihaqi Pahlevi Adam '
      end
    end # given block

    context 'given lambda' do
      it 'can fold numbers' do
        divider = -> (nbr, acc) { acc / nbr }
        result = Ohlist.foldl([4, 6], 48, divider)
        expect(result).to eq 2
      end

      it 'can fold string' do
        concatr = -> (name, str) { "#{str}#{name} " }
        result = Ohlist.foldl(['Adam', 'Pahlevi', 'Baihaqi'], '', concatr)
        expect(result).to eq 'Baihaqi Pahlevi Adam '
      end
    end # given lambda
  end # foldr
end  #Ohlist
