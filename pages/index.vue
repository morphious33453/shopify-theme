<template>
  <div id="home">
    <SfHero class="hero">
      <SfHeroItem
        v-for="(hero, i) in heroes"
        :key="i"
        :title="hero.title"
        :subtitle="hero.subtitle"
        :button-text="hero.buttonText"
        :background="hero.background"
        :image="$device.isDesktopOrTablet ? hero.image.desktop : hero.image.mobile"
        :class="hero.className"
      />
    </SfHero>
    <LazyHydrate when-visible>
      <SfBannerGrid :banner-grid="1" class="banner-grid">
        <template v-for="item in banners" #[item.slot]>
          <SfBanner
            :key="item.slot"
            :title="item.title"
            :subtitle="item.subtitle"
            :description="item.description"
            :button-text="item.buttonText"
            :image="item.image"
            :class="item.class"
          />
        </template>
      </SfBannerGrid>
    </LazyHydrate>
    <LazyHydrate when-visible>
      <RelatedProducts
        :products="products"
        :loading="productsLoading"
        title="Featured Products"
      />
    </LazyHydrate>

    <LazyHydrate when-visible>
      <SfCallToAction
        title="Need a Custom Quote?"
        button-text="Contact Us"
        description="Free design service • Same-day production • No minimums • Call (289) 228-7021"
        image=""
        class="call-to-action"
      />
    </LazyHydrate>
    <LazyHydrate when-visible>
      <MobileStoreBanner />
    </LazyHydrate>
  </div>
</template>
<script type="module">
import {
  SfHero,
  SfBanner,
  SfCallToAction,
  SfBannerGrid
} from '@storefront-ui/vue';
import {
  useProduct,
  useCart,
  productGetters
} from '@vue-storefront/shopify';
import {
  computed
} from '@nuxtjs/composition-api';
import LazyHydrate from 'vue-lazy-hydration';
import MobileStoreBanner from '~/components/MobileStoreBanner.vue';
import RelatedProducts from '~/components/RelatedProducts.vue';
import { onSSR } from '@vue-storefront/core';

export default {
  name: 'Home',
  components: {
    SfHero,
    RelatedProducts,
    SfBanner,
    SfCallToAction,
    SfBannerGrid,
    MobileStoreBanner,
    LazyHydrate
  },
  setup() {
    const {
      products: relatedProducts,
      search: productsSearch,
      loading: productsLoading
    } = useProduct('relatedProducts');
    const { cart, addItem: addToCart, isInCart } = useCart();

    onSSR(async () => {
      await productsSearch({ limit: 8 });
    });
    return {
      products: computed(() =>
        productGetters.getFiltered(relatedProducts.value, { master: true })
      ),
      getChkId: computed(() => cart.value.id),
      productsLoading,
      productGetters,
      addToCart,
      isInCart
    };
  },
  data() {
    return {
      heroes: [
        {
          title: 'Custom Signs & Printing Solutions',
          subtitle: 'NIAGARA\'S PREMIER PRINT SHOP',
          buttonText: 'Shop Now',
          background: 'linear-gradient(135deg, rgb(102, 126, 234) 0%, rgb(118, 75, 162) 100%)',
          image: {
            mobile: '',
            desktop: ''
          },
          link: '/c/best-sellers'
        },
        {
          title: 'NFC Review Cards - Get More 5-Star Reviews',
          subtitle: 'TAP TO TRUST™ TECHNOLOGY',
          buttonText: 'Learn More',
          background: 'rgb(196, 48, 28)',
          image: {
            mobile: '',
            desktop: ''
          },
          link: '/c/nfc-review-kits'
        },
        {
          title: 'Same-Day Printing & Rush Services',
          subtitle: 'FAST TURNAROUND - ORDER TODAY',
          buttonText: 'Get Quote',
          background: 'linear-gradient(135deg, rgb(102, 126, 234) 0%, rgb(118, 75, 162) 100%)',
          image: {
            mobile: '',
            desktop: ''
          },
          link: '/contact',
          className:
            'sf-hero-item--position-bg-top-left sf-hero-item--align-right'
        }
      ],
      banners: [
        {
          slot: 'banner-A',
          subtitle: 'Custom Stickers',
          title: 'Vinyl Decals & Labels',
          description:
            'Waterproof custom stickers, decals, and labels. No minimums, free design service. Perfect for branding, products, and promotions.',
          buttonText: 'Shop Stickers',
          image: {
            mobile: '',
            desktop: ''
          },
          class: 'sf-banner--slim desktop-only',
          link: '/c/custom-stickers-canada'
        },
        {
          slot: 'banner-B',
          subtitle: 'Heat Transfer Vinyl',
          title: 'Custom Apparel Printing',
          description:
            'Professional-grade heat transfer vinyl for custom apparel and fabric printing. Bulk pricing available for resellers.',
          buttonText: 'Shop HTV',
          image: {
            mobile: '',
            desktop: ''
          },
          class: 'sf-banner--slim banner-central desktop-only',
          link: '/c/heat-transfer-vinyl-canada'
        },
        {
          slot: 'banner-C',
          subtitle: 'NFC Technology',
          title: 'Tap to Review Cards',
          image: {
            mobile: '',
            desktop: ''
          },
          class: 'sf-banner--slim banner__tshirt',
          link: '/c/nfc-review-kits'
        },
        {
          slot: 'banner-D',
          subtitle: 'Best Sellers',
          title: 'Popular Products',
          image: {
            mobile: '',
            desktop: ''
          },
          class: 'sf-banner--slim',
          link: '/c/best-sellers'
        }
      ]
    };
  },
  methods: {
    toggleWishlist(index) {
      this.products[index].isInWishlist = !this.products[index].isInWishlist;
    }
  }
};
</script>

<style lang="scss" scoped>
#home {
  box-sizing: border-box;
  padding: 0 var(--spacer-sm);
  @include for-desktop {
    max-width: 1240px;
    padding: 0;
    margin: 0 auto;
  }
}
.hero {
  margin: var(--spacer-xl) auto var(--spacer-lg);
  --hero-item-background-position: center;
  @include for-desktop {
    margin: var(--spacer-xl) auto var(--spacer-2xl);
  }
  .sf-hero-item {
    &:nth-child(even) {
      --hero-item-background-position: left;
      @include for-mobile {
        --hero-item-background-position: 30%;
        ::v-deep .sf-hero-item__subtitle,
        ::v-deep .sf-hero-item__title {
          text-align: right;
          width: 100%;
          padding-left: var(--spacer-sm);
        }
      }
    }
  }
  ::v-deep .sf-hero__control {
    &--right,
    &--left {
      display: none;
    }
  }
}
.banner-grid {
  --banner-container-width: 50%;
  margin: var(--spacer-xl) 0;
  ::v-deep .sf-link:hover {
    color: var(--c-white);
  }
  @include for-desktop {
    margin: var(--spacer-2xl) 0;
    ::v-deep .sf-link {
      --button-width: auto;
      text-decoration: none;
    }
  }
}
.banner {
  &__tshirt {
    background-position: left;
  }
  &-central {
    @include for-desktop {
      --banner-container-flex: 0 0 70%;
    }
  }
}
.similar-products {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-bottom: var(--spacer-2xs);
  --heading-padding: 0;
  border-bottom: 1px var(--c-light) solid;
  @include for-desktop {
    border-bottom: 0;
    justify-content: center;
    padding-bottom: 0;
  }
}
.call-to-action {
  background-position: right;
  margin: var(--spacer-xs) 0;
  @include for-desktop {
    margin: var(--spacer-xl) 0 var(--spacer-2xl) 0;
  }
}
.carousel {
  margin: 0 calc(0 - var(--spacer-sm)) 0 0;
  @include for-desktop {
    margin: 0;
  }
  &__item {
    margin: 1.375rem 0 2.5rem 0;
    @include for-desktop {
      margin: var(--spacer-xl) 0 var(--spacer-xl) 0;
    }
    &__product {
      --product-card-add-button-transform: translate3d(0, 30%, 0);
    }
  }
  ::v-deep .sf-arrow--long .sf-arrow--right {
    --arrow-icon-transform: rotate(180deg);
    -webkit-transform-origin: center;
    transform-origin: center;
  }
}
</style>
