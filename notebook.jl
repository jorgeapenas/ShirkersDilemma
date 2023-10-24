### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ a1d5edf6-7cfe-4f07-b520-bad358b70876
begin
	using Pkg
	Pkg.activate("Project.toml")
	using Revise
	import ShirkersDilemma as SD
end

# ╔═╡ 05db2254-1f29-4c17-8547-dfc8cec0b456
begin
	using Plots
end

# ╔═╡ 196443bd-913a-483a-bd57-0af0ca9f29df
md"## Libraries"

# ╔═╡ 0ed771d2-d325-4c42-b7d9-333897de126e
md"Activate local environment:"

# ╔═╡ dfbf4914-34cc-483b-94bc-dd39c6633593
md"## Figures"

# ╔═╡ 4ba3da33-2d99-4dba-9c96-6076833b5f65
md"### Figure 1"

# ╔═╡ 92e2b9aa-c89d-4504-ba77-bb2a82b7259e
pl_Fig1 = SD.plot_pivot_dynamics(2,4)

# ╔═╡ 84e50aec-cc65-4fa4-8238-e0916fbdc9e9
savefig(pl_Fig1,"./figs/Fig1.pdf")

# ╔═╡ 4a645257-3c19-4bad-9148-8fcbc2dd3d2b
md"### Figure 2"

# ╔═╡ 1d292187-b726-4306-af6b-844a3043bf4d
pl_Fig2 = SD.plot_critical_costs(30,30)

# ╔═╡ 9787cc02-5fc6-4ed2-8b84-d5982a6cbe9e
savefig(pl_Fig2,"./figs/Fig2.pdf")

# ╔═╡ c317fb8b-c845-4682-803a-540dd7af0fdb
md"### Figure 3"

# ╔═╡ 2fb260c4-daf6-4642-969d-ee62eb520a70
pl_Fig3 = SD.plot_group_size_effect_on_pivot_probability(2,4,.2)

# ╔═╡ 5336d2ef-0dc9-443a-ac06-98408f3cbab4
savefig(pl_Fig3,"./figs/Fig3.pdf")

# ╔═╡ b26fd8cf-bdf6-460f-bfa3-ef3bb1e75ffe
md"### Figure 4"

# ╔═╡ 5b75cdcf-233f-45df-aee8-a655be1f7323
pl_p = SD.plot_p(30,0.2)

# ╔═╡ dfb0e5f1-02b9-4ec2-9b44-2cc165cf607e
pl_u = SD.plot_u(30,0.2)

# ╔═╡ ab8234bf-3708-4848-b73c-9946a5e58cdf
pl_Fig4=plot(pl_p,pl_u,layout=(1,2),size=(600,300))

# ╔═╡ ce015360-c632-4285-9630-82557f0e5b5b
savefig(pl_Fig4,"./figs/Fig4.pdf")

# ╔═╡ 8aa82202-c557-448a-a392-3584f3e7df73
md"### Figure 5"

# ╔═╡ 83974d99-5102-4b00-b485-0562fd36ebdc
pl_Fig5 = SD.plot_p_heatmap(30)

# ╔═╡ 3c37bb93-e768-4b16-84e6-4d451387f7ab
savefig(pl_Fig5,"./figs/Fig5.pdf")

# ╔═╡ 39adac8e-9253-422a-a798-16f70634dd2d
md"### Figure 6"

# ╔═╡ c8bee348-a463-46fd-8052-6ec9377280eb
pl_Fig6 = SD.plot_basin_heatmap(30)

# ╔═╡ 14a93dff-236f-4663-a1c2-35e664549e77
savefig(pl_Fig6,"./figs/Fig6.pdf")

# ╔═╡ 03a503fd-f0bd-414c-ba22-a3332c578f83
md"### Figure 7"

# ╔═╡ 381274cb-96a0-4d5b-bffa-df199151103c
pl_Fig7 = SD.plot_u_heatmap(30)

# ╔═╡ 07a7ac57-08f0-4180-9890-c069cde116e1
savefig(pl_Fig7,"./figs/Fig7.pdf")

# ╔═╡ ddfd4e62-4144-408e-a910-c04e81172c23
md"### Figure 8"

# ╔═╡ 100e204e-1dab-4c33-bcfb-5f41c66aee36
pl_phi = SD.plot_ϕ(30,0.2)

# ╔═╡ 5ef6a226-cca1-45ad-a5dd-c06f2dcf1389
pl_phi_2 = SD.plot_ϕ_2()

# ╔═╡ 0d05cf93-0e5f-4919-9cd7-29afd6363e2d
pl_Fig8=plot(pl_phi_2,pl_phi,layout=(1,2),size=(600,300))

# ╔═╡ 024de5f2-2488-466c-baf8-3673440a7369
savefig(pl_Fig8,"./figs/Fig8.pdf")

# ╔═╡ 51b1a822-839d-4ded-a866-9d195941cc51
md"### Figure 9"

# ╔═╡ d1681659-ceab-42b5-b461-24d7ae299381
pl_Fig9 = SD.plot_ϕ_heatmap(30)

# ╔═╡ 0b0a6317-2253-4b6b-a089-b33efe7682c1
savefig(pl_Fig9,"./figs/Fig9.pdf")

# ╔═╡ 83b162d8-d17c-43c7-ae48-31fce0f6faf3
md"### Figure 10"

# ╔═╡ 03265d6e-71f0-48a9-a1a9-235de8579c7c
pl_pivot_Poisson = SD.plot_pivot_Poisson(2,0.2)

# ╔═╡ 73c896fa-3e2d-4d48-9fee-76db446403a7
pl_limit_p = SD.plot_limit_p()

# ╔═╡ 4e1baa4d-c2f8-4a8b-90ae-ba006e6795da
pl_limit_u = SD.plot_limit_u()

# ╔═╡ 3eb4c222-234f-4230-9b49-4802a0ecc12b
pl_limit_phi = SD.plot_limit_ϕ()

# ╔═╡ 2304c10b-5408-43cb-959f-a18bbef6cbc8
pl_Fig10=plot(pl_pivot_Poisson,pl_limit_p,pl_limit_u,pl_limit_phi,layout=(2,2))

# ╔═╡ 46c44f40-b9dc-444d-8afb-7f41685c0a60
savefig(pl_Fig10,"./figs/Fig10.pdf")

# ╔═╡ Cell order:
# ╠═196443bd-913a-483a-bd57-0af0ca9f29df
# ╠═0ed771d2-d325-4c42-b7d9-333897de126e
# ╠═a1d5edf6-7cfe-4f07-b520-bad358b70876
# ╠═05db2254-1f29-4c17-8547-dfc8cec0b456
# ╟─dfbf4914-34cc-483b-94bc-dd39c6633593
# ╟─4ba3da33-2d99-4dba-9c96-6076833b5f65
# ╠═92e2b9aa-c89d-4504-ba77-bb2a82b7259e
# ╠═84e50aec-cc65-4fa4-8238-e0916fbdc9e9
# ╠═4a645257-3c19-4bad-9148-8fcbc2dd3d2b
# ╠═1d292187-b726-4306-af6b-844a3043bf4d
# ╠═9787cc02-5fc6-4ed2-8b84-d5982a6cbe9e
# ╠═c317fb8b-c845-4682-803a-540dd7af0fdb
# ╠═2fb260c4-daf6-4642-969d-ee62eb520a70
# ╠═5336d2ef-0dc9-443a-ac06-98408f3cbab4
# ╠═b26fd8cf-bdf6-460f-bfa3-ef3bb1e75ffe
# ╠═5b75cdcf-233f-45df-aee8-a655be1f7323
# ╠═dfb0e5f1-02b9-4ec2-9b44-2cc165cf607e
# ╠═ab8234bf-3708-4848-b73c-9946a5e58cdf
# ╠═ce015360-c632-4285-9630-82557f0e5b5b
# ╠═8aa82202-c557-448a-a392-3584f3e7df73
# ╠═83974d99-5102-4b00-b485-0562fd36ebdc
# ╠═3c37bb93-e768-4b16-84e6-4d451387f7ab
# ╠═39adac8e-9253-422a-a798-16f70634dd2d
# ╠═c8bee348-a463-46fd-8052-6ec9377280eb
# ╠═14a93dff-236f-4663-a1c2-35e664549e77
# ╠═03a503fd-f0bd-414c-ba22-a3332c578f83
# ╠═381274cb-96a0-4d5b-bffa-df199151103c
# ╠═07a7ac57-08f0-4180-9890-c069cde116e1
# ╠═ddfd4e62-4144-408e-a910-c04e81172c23
# ╠═100e204e-1dab-4c33-bcfb-5f41c66aee36
# ╠═5ef6a226-cca1-45ad-a5dd-c06f2dcf1389
# ╠═0d05cf93-0e5f-4919-9cd7-29afd6363e2d
# ╠═024de5f2-2488-466c-baf8-3673440a7369
# ╠═51b1a822-839d-4ded-a866-9d195941cc51
# ╠═d1681659-ceab-42b5-b461-24d7ae299381
# ╠═0b0a6317-2253-4b6b-a089-b33efe7682c1
# ╠═83b162d8-d17c-43c7-ae48-31fce0f6faf3
# ╠═03265d6e-71f0-48a9-a1a9-235de8579c7c
# ╠═73c896fa-3e2d-4d48-9fee-76db446403a7
# ╠═4e1baa4d-c2f8-4a8b-90ae-ba006e6795da
# ╠═3eb4c222-234f-4230-9b49-4802a0ecc12b
# ╠═2304c10b-5408-43cb-959f-a18bbef6cbc8
# ╠═46c44f40-b9dc-444d-8afb-7f41685c0a60
