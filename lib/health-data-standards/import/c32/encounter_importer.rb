module HealthDataStandards
  module Import
    module C32
      class EncounterImporter < CDA::EncounterImporter

        #@section_importers[:encounters] = [
        #  * generate_importer(CDA::EncounterImporter, "//cda:encounter[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.23']", '2.16.840.1.113883.3.560.1.79', 'performed'), #encounter performed ******
        #    generate_importer(EncounterOrderImporter, nil, '2.16.840.1.113883.3.560.1.83', 'ordered')
        #]

        def initialize
          super
        end

        def create_entry
          entry = super
          entry.oid = '2.16.840.1.113883.3.560.1.79'
          entry
        end

      end
    end
  end
end
