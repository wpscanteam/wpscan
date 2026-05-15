# frozen_string_literal: true

describe WPScan::DB::DynamicFinders::Plugin do
  subject(:dynamic_finders) { described_class }

  describe '.finders_configs' do
    context 'when the given class is not allowed' do
      it 'returns an empty hash' do
        expect(subject.finder_configs('aaaa')).to eql({})
      end
    end

    context 'when the given class is allowed' do
      context 'when aggressive argument is false' do
        it 'returns only the configs w/o a path parameter' do
          configs = subject.finder_configs(:Xpath)

          expect(configs.keys).to include('wordpress-mobile-pack', 'shareaholic')
          expect(configs.keys).to_not include('simple-share-button-adder')

          expect(configs['sitepress-multilingual-cms']['MetaGenerator']['pattern']).to be_a Regexp
          expect(configs['sitepress-multilingual-cms']['MetaGenerator']['version']).to eql true
        end
      end

      context 'when aggressive argument is true' do
        it 'returns only the configs with a path parameter' do
          configs = subject.finder_configs(:Xpath, aggressive: true)

          expect(configs.keys).to include('revslider')
          expect(configs.keys).to_not include('shareaholic')
        end
      end
    end
  end

  describe '.versions_finders_configs' do
    # Just test a sample here
    its('versions_finders_configs.keys') { should include('shareaholic') }
    its('versions_finders_configs.keys') { should_not include('wordpress-mobile-pack') }
  end

  describe '.maybe_create_module' do
    let(:slug) { 'test-plugin' }
    let(:module_name) { :TestPlugin }

    after do
      # Clean up created modules after each test
      if WPScan::Finders::PluginVersion.const_defined?(module_name, false)
        WPScan::Finders::PluginVersion.send(:remove_const, module_name)
      end
    end

    context 'when the module does not exist' do
      it 'creates and returns a new module' do
        expect(WPScan::Finders::PluginVersion.const_defined?(module_name, false)).to be false

        result = subject.maybe_create_module(slug)

        expect(result).to be_a Module
        expect(WPScan::Finders::PluginVersion.const_defined?(module_name, false)).to be true
        expect(WPScan::Finders::PluginVersion.const_get(module_name)).to eq result
      end
    end

    context 'when the module already exists' do
      before do
        WPScan::Finders::PluginVersion.const_set(module_name, Module.new)
      end

      it 'returns the existing module without creating a new one' do
        existing_module = WPScan::Finders::PluginVersion.const_get(module_name)

        result = subject.maybe_create_module(slug)

        expect(result).to eq existing_module
        expect(result).to be_a Module
      end
    end

    context 'when the slug contains special characters' do
      let(:slug) { '123-test-plugin' }
      let(:module_name) { :D_123TestPlugin }

      it 'classifies the slug correctly and creates the module' do
        result = subject.maybe_create_module(slug)

        expect(result).to be_a Module
        expect(WPScan::Finders::PluginVersion.const_defined?(module_name, false)).to be true
      end
    end
  end

  describe '.create_versions_finders' do
    # handled and tested in spec/lib/finders/dynamic_finders/plugin_version_spec

    context 'When trying to create the finders twice' do
      # let's just test one slug, no need to test them all
      let(:slug) { '12-step-meeting-list' }

      it 'does not raise an error when the class already exists' do
        WPScan::DB::DynamicFinders::Plugin.create_versions_finders(slug)

        expect { WPScan::DB::DynamicFinders::Plugin.create_versions_finders(slug) }.to_not raise_error
      end
    end

    context 'when the slug contains non alpha-numeric chars' do
      let(:slug) { 'test.something' }

      it 'sanitize it and does not raise an error' do
        expect { WPScan::DB::DynamicFinders::Plugin.create_versions_finders(slug) }.to_not raise_error
      end
    end
  end

  describe '.version_finder_super_class' do
    # handled and tested in spec/lib/finders/dynamic_finders/plugin_version_spec
  end

  describe '.method_missing' do
    context 'when the method matches a valid call' do
      its('passive_comment_finder_configs.keys') { should include('addthis') }
      its('passive_comment_finder_configs.keys') { should_not include('shareaholic') }

      its('passive_xpath_finder_configs.keys') { should include('shareaholic') }
      its('passive_xpath_finder_configs.keys') { should_not include('simple-share-button-adder') }
      its('aggressive_xpath_finder_configs.keys') { should_not include('wordpress-mobile-pack') }
      its('aggressive_xpath_finder_configs.keys') { should include('revslider') }
    end

    context 'when the method does not match a valid call' do
      it 'raises an error' do
        expect { subject.aaa }.to raise_error(NoMethodError)
      end
    end
  end
end
