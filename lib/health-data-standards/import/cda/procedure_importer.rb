module HealthDataStandards
  module Import
    module CDA
      class ProcedureImporter < SectionImporter

        #scoped to not look in the plan of care section so planned procedures do not end up mixed with
        #past procedures
        def initialize(entry_finder=EntryFinder.new("//cda:section[cda:templateId/@root!='2.16.840.1.113883.3.88.11.83.124']//cda:procedure"))
          super(entry_finder)
          @entry_class = Procedure
          @reason_xpath = "./cda:entryRelationship[@typeCode='RSON']/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.24.3.88']/cda:value"
          
          # The "Preventive Care and Screening: Screening for Clinical Depression and Follow-Up Plan" measure was failing
          # because this was not getting on procedure entries, letting it back in!
          #@value_xpath = nil
        end
        
        def create_entry(entry_element, nrh = NarrativeReferenceHandler.new)
          procedure = super
          extract_performer(entry_element, procedure)
          extract_site(entry_element, procedure)
          extract_negation(entry_element, procedure)
          procedure.reason = extract_code(entry_element, @reason_xpath, 'SNOMED-CT')
          procedure.status_code = {'HL7 ActStatus' => ['ordered']}
          procedure
        end

        private

        def extract_performer(parent_element, procedure)
          performer_element = parent_element.at_xpath("./cda:performer")
          procedure.performer = import_actor(performer_element) if performer_element
        end

        def extract_site(parent_element, procedure)
          procedure.site = extract_code(parent_element, "./cda:targetSiteCode")
        end

        def extract_code(parent_element, code_xpath, code_system=nil)
          code_element = parent_element.at_xpath(code_xpath)
          code_hash = nil
          if code_element
            code_hash = {'code' => code_element['code']}
            if code_system
              code_hash['code_system'] = code_system
            end
          end
          code_hash
        end

      end
    end
  end
end