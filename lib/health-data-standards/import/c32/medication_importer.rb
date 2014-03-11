module HealthDataStandards
  module Import
    module C32
      class MedicationImporter < CDA::MedicationImporter

        #@section_importers[:medications] = [
        #    generate_importer(CDA::MedicationImporter, "//cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.24.3.105']/cda:entryRelationship/cda:substanceAdministration[cda:templateId/@root='2.16.840.1.113883.10.20.24.3.41']", '2.16.840.1.113883.3.560.1.199', 'discharge'), #discharge medication active
        #  * generate_importer(MedicationActiveImporter, nil, '2.16.840.1.113883.3.560.1.13', 'active'), #medication active ******
        #  * generate_importer(CDA::MedicationImporter, "//cda:act[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.42']/cda:entryRelationship/cda:substanceAdministration[cda:templateId/@root='2.16.840.1.113883.10.20.22.4.16']", '2.16.840.1.113883.3.560.1.14', 'administered'), #medication administered ******
        #  * generate_importer(CDA::MedicationImporter, "//cda:substanceAdministration[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.47']", '2.16.840.1.113883.3.560.1.17', 'ordered'), #medication order TODO: ADD NEGATON REASON HANDLING SOMEHOW ******
        #  * generate_importer(MedicationDispensedImporter, nil, '2.16.840.1.113883.3.560.1.8', 'dispensed') # ******
        #]

        def initialize
          super
        end

        def create_entry
          entry = super

          case entry.status.to_s.downcase
            when 'active' then entry.oid = '2.16.840.1.113883.3.560.1.13'

            # TODO Assure this is getting set in mirth
            when 'administered' then entry.oid = '2.16.840.1.113883.3.560.1.14'

            when 'ordered' then entry.oid = '2.16.840.1.113883.3.560.1.17'
            when 'dispensed' then entry.oid = '2.16.840.1.113883.3.560.1.8'
          end

          entry
        end

      end
    end
  end
end
