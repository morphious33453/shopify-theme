<template>
  <div class="sf-header__navigation desktop" v-if="!isMobile">
    <SfHeaderNavigationItem
      v-for="(category, index) in categoryLinks"
      :key="index"
      class="nav-item"
      v-e2e="`app-header-url_${category.label}`"
      :label="category.label"
      :link="localePath(category.link)"
    />
  </div>
  <SfModal v-else :visible="isMobileMenuOpen">
    <SfHeaderNavigationItem
      v-for="(category, index) in categoryLinks"
      :key="index"
      class="nav-item"
      v-e2e="`app-header-url_${category.label}`"
    >
      <template #mobile-navigation-item>
        <SfMenuItem
          :label="category.label"
          class="sf-header-navigation-item__menu-item"
          :link="localePath(category.link)"
          @click="toggleMobileMenu"
        />
      </template>
    </SfHeaderNavigationItem>
  </SfModal>
</template>

<script>
import { SfMenuItem, SfModal } from '@storefront-ui/vue';
import { useUiState } from '~/composables';

export default {
  name: 'HeaderNavigation',
  components: {
    SfMenuItem,
    SfModal
  },
  props: {
    isMobile: {
      type: Boolean,
      default: false
    }
  },
  setup() {
    const { isMobileMenuOpen, toggleMobileMenu } = useUiState();

    const categoryLinks = [
      { label: 'NFC Review Cards', link: '/c/nfc-review-kits' },
      { label: 'Custom Stickers', link: '/c/custom-stickers-canada' },
      { label: 'Heat Transfer Vinyl', link: '/c/heat-transfer-vinyl-canada' },
      { label: 'Best Sellers', link: '/c/best-sellers' },
      { label: 'Contact', link: '/contact' }
    ];

    return {
      categoryLinks,
      isMobileMenuOpen,
      toggleMobileMenu
    };
  }
};
</script>

<style lang="scss" scoped>
.sf-header-navigation-item {
  ::v-deep &__item--mobile {
    display: block;
  }
}
.sf-modal {
  ::v-deep &__bar {
    display: none;
  }
  ::v-deep &__content {
    padding: var(--modal-content-padding, var(--spacer-base) 0);
  }
}
</style>
