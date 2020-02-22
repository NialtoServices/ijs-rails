# frozen_string_literal: true

RSpec.describe IJSRails::Script do
  def rails_path(*options)
    Rails.root.join(*options).to_s
  end

  def add_cache_file(data = '')
    FileUtils.mkdir_p(File.dirname(cache_file_path))
    File.write(cache_file_path, data)
  end

  def read_cache_file
    File.read(cache_file_path)
  end

  def remove_cache_file
    FileUtils.rm_f(cache_file_path)
  end

  after { remove_cache_file }

  let(:name)            { 'demo/hello' }
  let(:fingerprint)     { '453138908' }
  let(:file_name)       { "#{name}.js" }
  let(:file_path)       { rails_path('app/javascript/inline', file_name) }
  let(:cache_file_name) { "#{name}-#{fingerprint}.min.js" }
  let(:cache_file_path) { rails_path('tmp/ijs', cache_file_name) }
  let(:options) do
    {}
  end

  subject(:script) { described_class.new(name, options) }

  it { is_expected.to respond_to(:script) }
  it { is_expected.to respond_to(:options) }

  describe '#file_path' do
    subject { script.file_path }

    it 'returns the correct path' do
      expect(subject).to eq(file_path)
    end

    it 'uses the path from the Rails configuration' do
      expect(Rails.application.config.inline_js).to receive(:path).and_return(rails_path('app/ijs'))
      expect(subject).to eq(rails_path('app/ijs', file_name))
    end
  end

  describe '#fingerprint' do
    subject { script.fingerprint }

    it 'computes the correct fingerprint' do
      expect(subject).to eq(fingerprint)
    end
  end

  describe '#cache_file_path' do
    subject { script.cache_file_path }

    it 'returns the correct path' do
      expect(subject).to eq(cache_file_path)
    end

    it 'uses the path from the Rails configuration' do
      expect(Rails.application.config.inline_js).to receive(:cache_path).and_return(rails_path('tmp/cache/ijs'))
      expect(subject).to eq(rails_path('tmp/cache/ijs', cache_file_name))
    end
  end

  describe '#cached?' do
    subject { script.cached? }

    context 'when not cached' do
      it { is_expected.to eq(false) }
    end

    context 'when cached' do
      before { add_cache_file }

      it { is_expected.to eq(true) }
    end
  end

  describe '#isolate?' do
    subject { script.isolate? }

    context 'with defaults' do
      it { is_expected.to eq(true) }
    end

    context 'when #options[:isolate] is true' do
      let(:options) do
        { isolate: true }
      end

      it { is_expected.to eq(true) }
    end

    context 'when #options[:isolate] is false' do
      let(:options) do
        { isolate: false }
      end

      it { is_expected.to eq(false) }
    end
  end

  describe '#compile!' do
    let(:result) { 'alert("Hello, World!");' }

    subject { script.compile! }

    it 'returns the compiled script' do
      expect(subject).to eq(result)
    end

    it 'caches the compiled script' do
      subject
      expect(read_cache_file).to eq(result)
    end
  end

  describe '#compiled' do
    subject { script.compiled }

    context 'when cached' do
      before { add_cache_file '// JS' }

      it 'returns the contents of the cached file' do
        expect(subject).to eq('// JS')
      end
    end

    context 'when not cached' do
      it 'compiles the script' do
        expect(script).to receive(:compile!)
        subject
      end
    end
  end
end
