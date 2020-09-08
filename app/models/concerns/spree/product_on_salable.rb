module Spree
  module ProductOnSalable
    extend ActiveSupport::Concern

    included do
      has_many :sale_prices, through: :prices

      # Essentially all read values here are delegated to reading the value on the Master variant
      # All write values will write to all variants (including the Master) unless that method's all_variants parameter is set to false, in which case it will only write to the Master variant

      delegate_belongs_to :master, :active_sale_in, :current_sale_in, :next_active_sale_in, :next_current_sale_in,
                          :sale_price_in, :on_sale_in?, :original_price_in, :discount_percent_in, :sale_price,
                          :original_price, :on_sale?

      # Entrega los productos con descuento
      scope :in_sale, -> {
                          joins(master: :sale_prices)
                          .where(spree_sale_prices: {enabled: true})
                          .where('spree_sale_prices.value < spree_prices.amount')
                          .where('spree_sale_prices.start_at <= ? OR spree_sale_prices.start_at IS NULL', Time.now.round)
                          .where('spree_sale_prices.end_at   >= ? OR spree_sale_prices.end_at   IS NULL', Time.now.round)
                          .uniq
                         }
    end

    # TODO also accept a class reference for calculator type instead of only a string
    def put_on_sale value, params={}
      if !params[:variant] or params[:variant] == 'all_variants' or params[:variant] == :all_variants
        run_on_variants(true) { |v| v.put_on_sale(value, params) }
      elsif params[:variant]
        variants_including_master.find(params[:variant]).put_on_sale(value, params) if variants_including_master.exists?(id: params[:variant])
      end
      touch
    end
    alias :create_sale :put_on_sale

    def enable_sale(all_variants = true)
      run_on_variants(all_variants) { |v| v.enable_sale }
    end

    def disable_sale(all_variants = true)
      run_on_variants(all_variants) { |v| v.disable_sale }
    end

    def start_sale(end_time = nil, all_variants = true)
      run_on_variants(all_variants) { |v| v.start_sale(end_time) }
    end

    def stop_sale(all_variants = true)
      run_on_variants(all_variants) { |v| v.stop_sale }
    end

    private
      def run_on_variants(all_variants, &block)
        if all_variants && variants.present?
          variants.each { |v| block.call v }
        end
        block.call master
      end
    end
  end
