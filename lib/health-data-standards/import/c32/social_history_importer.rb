module HealthDataStandards
  module Import
    module C32
      class SocialHistoryImporter < CDA::SectionImporter

        #@section_importers[:social_history] = [
        #  * generate_importer(TobaccoUseImporter, nil, '2.16.840.1.113883.3.560.1.1001', 'completed') # ******
        #]

        def initialize
          super(CDA::EntryFinder.new("//cda:observation[cda:templateId/@root='2.16.840.1.113883.3.88.11.83.19']"))
        end

        def create_entry
          entry = super
          entry.oid = '2.16.840.1.113883.3.560.1.1001'
          entry
        end

      end
    end
  end
end
