module GreyscaleRails
  module Patchable
    extend ActiveSupport::Concern

    included do
      before_action :apply_patch
      after_action  :remove_patch

      def apply_patch
        revision = params[:revision]

        if revision.present?

          definition = patch_driver.load! revision
          
          patch = Hana::Patch.new( definition[:patch] )

          GreyscaleRecord::Base.data_store.apply_patch patch

          Rails.logger.debug "Aplying patch: #{patch.inspect}"
        end
      rescue => e
        Rails.logger.error "Failed to apply patch #{revision}: #{e}"

        GreyscaleRecord::Base.data_store.remove_patch
      end

      def remove_patch
        GreyscaleRecord::Base.data_store.remove_patch
      end

      private

      def patch_driver
        GreyscaleRails.patch_driver
      end
    end
  end
end