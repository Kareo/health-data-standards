module HealthDataStandards
  module Import
    module Cat1
      class EntryPackage

        attr_accessor :importer_type, :hqmf_oid, :status

        def initialize (type, oid, stat = nil)
          self.importer_type = type
          self.hqmf_oid = oid
          self.status = stat
        end  

        def package_entries (doc, nrh)
          entries = self.importer_type.create_entries(doc, nrh)

          # Figure out correct negative/positive oids for this importer
          oid_mapping = HealthDataStandards::Util::HQMFTemplateHelper.template_id_map[hqmf_oid]
          if oid_mapping['negation']
            negative_oid= hqmf_oid
            positive_oid = HealthDataStandards::Util::HQMFTemplateHelper.template_id_by_definition_and_status(
                oid_mapping['definition'], oid_mapping['status'], true)
          else
            positive_oid = hqmf_oid
            negative_oid = HealthDataStandards::Util::HQMFTemplateHelper.template_id_by_definition_and_status(
                oid_mapping['definition'], oid_mapping['status'], false)
          end

          entries.each do |entry|
            # Customize oid for this specific entry
            if !!entry.negationInd
              entry.oid = negative_oid
            else
              entry.oid = positive_oid
            end

            entry.status = self.status
          end          
          entries
        end
      end
    end
  end
end