module HealthDataStandards
  module Import
    module C32
      class ResultImporter < CDA::ResultImporter

        #@section_importers[:results] = [
        #  * generate_importer(LabOrderImporter, nil, '2.16.840.1.113883.3.560.1.50', 'ordered'), #lab ordered ******
        #    generate_importer(CDA::ResultImporter, "//cda:observation[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.38']", '2.16.840.1.113883.3.560.1.5', 'performed'), #lab performed
        #    generate_importer(CDA::ResultImporter, "//cda:act[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.34']", '2.16.840.1.113883.3.560.1.47'), #intervention result
        #  * generate_importer(CDA::ResultImporter, "//cda:observation[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.57']", '2.16.840.1.113883.3.560.1.18'), #physical exam finding ******
        #  * generate_importer(CDA::ResultImporter, "//cda:observation[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.28']", '2.16.840.1.113883.3.560.1.88'), #functional status result     ******
        #    generate_importer(CDA::ResultImporter, "//cda:observation[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.20']", '2.16.840.1.113883.3.560.1.111'), #diagnostic study result not done
        #  * generate_importer(LabResultImporter, nil, '2.16.840.1.113883.3.560.1.12') #lab result ******
        #]

        def initialize
          super
        end

        def create_entry
          entry = super

          case
            when false then entry.oid = '2.16.840.1.113883.3.560.1.50'
            when false then entry.oid = '2.16.840.1.113883.3.560.1.18'
            when false then entry.oid = '2.16.840.1.113883.3.560.1.88'
            when false then entry.oid = '2.16.840.1.113883.3.560.1.12'
          end

          entry
        end

      end
    end
  end
end
