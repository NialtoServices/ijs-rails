# frozen_string_literal: true

RSpec.describe IJSRails::ActionViewHelpers do
  subject(:view) { ActionController::Base.new.view_context }

  describe '#render_ijs' do
    let(:name) { 'demo/hello' }

    subject { view.render_ijs(name) }

    it 'returns an HTML <script> tag containing the script' do
      expect(subject).to have_tag(:script, text: 'alert("Hello, World!");')
    end

    context 'when :type is provided' do
      let(:type) { 'application/type' }

      subject { view.render_ijs(name, type: type) }

      it 'sets the :type attribute on the <script> element' do
        expect(subject).to have_tag(:script, with: { type: type })
      end
    end
  end
end
