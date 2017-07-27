module GreyscaleRails
  module Patchable
    extend ActiveSupport::Concern

    included do
      before_filter :apply_patch
      after_filter  :remove_patch

      def apply_patch
        revision = params[:revision]

        if revision.present?

          patch_json = patch_driver.load! revision
          patch = Hana::Patch.new( JSON.parse( patch_json ) )

          GreyscaleRecord::Base.data_store.apply_patch patch
        end
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