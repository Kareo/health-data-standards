module HealthDataStandards
  module Import
    module C32
      class ProcedureImporter < CDA::ProcedureImporter

        #@section_importers[:procedures] = [
        #    generate_importer(CDA::ProcedureImporter, "//cda:observation[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.59']", '2.16.840.1.113883.3.560.1.57', 'performed'), #physical exam performed
        #    generate_importer(CDA::ProcedureImporter, "//cda:act[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.3']", '2.16.840.1.113883.3.560.1.131'), #comm from provider to patient
        #    generate_importer(CDA::ProcedureImporter, "//cda:act[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.31']", '2.16.840.1.113883.3.560.1.45', 'ordered'), #intervention ordered
        #  * generate_importer(CDA::ProcedureImporter, "//cda:act[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.32']", '2.16.840.1.113883.3.560.1.46', 'performed'), #intervention performed ******
        #    generate_importer(CDA::ProcedureImporter, "//cda:act[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.34']", '2.16.840.1.113883.3.560.1.47'), #intervention result
        #  * generate_importer(CDA::ProcedureImporter, "//cda:act[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.4']", '2.16.840.1.113883.3.560.1.129'), #comm from provider to provider ******
        #    generate_importer(CDA::ProcedureImporter, "//cda:act[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.2']", '2.16.840.1.113883.3.560.1.30'), #comm from patient to provider
        #    generate_importer(ProcedureOrderImporter, nil, '2.16.840.1.113883.3.560.1.62', 'ordered'),
        #  * generate_importer(CDA::ProcedureImporter, "//cda:procedure[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.64']", '2.16.840.1.113883.3.560.1.6', 'performed'), # documented medications from patient to provider ******
        #    generate_importer(CDA::ProcedureImporter, "//cda:procedure[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.66']", '2.16.840.1.113883.3.560.1.63'),
        #  * generate_importer(CDA::ProcedureImporter, "//cda:observation[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.69']", '2.16.840.1.113883.3.560.1.21'), # ******
        #  * generate_importer(CDA::ProcedureImporter, "//cda:observation[cda:templateId/@root = '2.16.840.1.113883.10.20.24.3.18']", '2.16.840.1.113883.3.560.1.103', 'performed'), #diagnostic study performed ****
        #  * generate_importer(DiagnosticStudyOrderImporter, nil, '2.16.840.1.113883.3.560.1.40', 'ordered') # ******
        #]

        def initialize
          super
        end

        def create_entry
          entry = super

          case entry.status
            when false then entry.oid = '2.16.840.1.113883.3.560.1.46'
            when false then entry.oid = '2.16.840.1.113883.3.560.1.129' # Negation sensitive relative to 29!
            when false then entry.oid = '2.16.840.1.113883.3.560.1.6' # Negation sensitive relative to 106!
            when false then entry.oid = '2.16.840.1.113883.3.560.1.21'
            when false then entry.oid = '2.16.840.1.113883.3.560.1.103' # Negation sensitive relative to 3!
            when false then entry.oid = '2.16.840.1.113883.3.560.1.40'
          end

          entry
        end

      end
    end
  end
end
