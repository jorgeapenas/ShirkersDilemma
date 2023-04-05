### A Pluto.jl notebook ###
# v0.19.9

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

# ╔═╡ 8515b2c8-d3a9-11ed-10c4-b77658263370


# ╔═╡ 196443bd-913a-483a-bd57-0af0ca9f29df
md"## Libraries"

# ╔═╡ 0ed771d2-d325-4c42-b7d9-333897de126e
md"Activate local environment:"

# ╔═╡ dfbf4914-34cc-483b-94bc-dd39c6633593
md"## Figures"

# ╔═╡ 4ba3da33-2d99-4dba-9c96-6076833b5f65
md"### Figure 1"

# ╔═╡ 92e2b9aa-c89d-4504-ba77-bb2a82b7259e
pl_pivot_dynamics = SD.plot_pivot_dynamics(2,4)

# ╔═╡ 84e50aec-cc65-4fa4-8238-e0916fbdc9e9
savefig(pl_pivot_dynamics,"./figs/fig_dynamics.pdf")

# ╔═╡ 4a645257-3c19-4bad-9148-8fcbc2dd3d2b
md"### Figure 2"

# ╔═╡ 1d292187-b726-4306-af6b-844a3043bf4d
pl_critical_costs = SD.plot_critical_costs(30,30)

# ╔═╡ 9787cc02-5fc6-4ed2-8b84-d5982a6cbe9e
savefig(pl_critical_costs,"./figs/fig_costs.pdf")

# ╔═╡ c317fb8b-c845-4682-803a-540dd7af0fdb
md"### Figure 3"

# ╔═╡ 5b75cdcf-233f-45df-aee8-a655be1f7323
pl_p = SD.plot_p(30,0.2)

# ╔═╡ dfb0e5f1-02b9-4ec2-9b44-2cc165cf607e
pl_u = SD.plot_u(30,0.2)

# ╔═╡ e8d17680-c6dc-41cf-9761-79bbe0cebdc7
pl_phi = SD.plot_ϕ(30,0.2)

# ╔═╡ 616a210d-fa75-492a-8c53-67a4e1842346
pl_phi_2 = SD.plot_ϕ_2()

# ╔═╡ 3fa8b0c7-dc5a-4a19-a5fb-79a0b56e830a
pl_Fig_3=plot(pl_p,pl_u,pl_phi,pl_phi_2,layout=(2,2))

# ╔═╡ 6cddb256-2e32-473b-ad7f-8b1ce4978a62
savefig(pl_Fig_3,"./figs/fig_p_phi_u.pdf")

# ╔═╡ 8aa82202-c557-448a-a392-3584f3e7df73
md"### Figure 4"

# ╔═╡ 83974d99-5102-4b00-b485-0562fd36ebdc
pl_p_heatmap = SD.plot_p_heatmap(30)

# ╔═╡ 3c37bb93-e768-4b16-84e6-4d451387f7ab
savefig(pl_p_heatmap,"./figs/fig_p.pdf")

# ╔═╡ 39adac8e-9253-422a-a798-16f70634dd2d
md"### Figure 5"

# ╔═╡ c8bee348-a463-46fd-8052-6ec9377280eb
pl_basin_heatmap = SD.plot_basin_heatmap(30)

# ╔═╡ 14a93dff-236f-4663-a1c2-35e664549e77
savefig(pl_basin_heatmap,"./figs/fig_basin.pdf")

# ╔═╡ 03a503fd-f0bd-414c-ba22-a3332c578f83
md"### Figure 6"

# ╔═╡ 381274cb-96a0-4d5b-bffa-df199151103c
pl_u_heatmap = SD.plot_u_heatmap(30)

# ╔═╡ 07a7ac57-08f0-4180-9890-c069cde116e1
savefig(pl_u_heatmap,"./figs/fig_u.pdf")

# ╔═╡ 51b1a822-839d-4ded-a866-9d195941cc51
md"### Figure 7"

# ╔═╡ d1681659-ceab-42b5-b461-24d7ae299381
pl_phi_heatmap = SD.plot_ϕ_heatmap(30)

# ╔═╡ 0b0a6317-2253-4b6b-a089-b33efe7682c1
savefig(pl_phi_heatmap,"./figs/fig_phi.pdf")

# ╔═╡ 83b162d8-d17c-43c7-ae48-31fce0f6faf3
md"### Figure 8"

# ╔═╡ 03265d6e-71f0-48a9-a1a9-235de8579c7c
pl_pivot_Poisson = SD.plot_pivot_Poisson(2,0.2)

# ╔═╡ 73c896fa-3e2d-4d48-9fee-76db446403a7
pl_limit_p = SD.plot_limit_p()

# ╔═╡ 4e1baa4d-c2f8-4a8b-90ae-ba006e6795da
pl_limit_u = SD.plot_limit_u()

# ╔═╡ 3eb4c222-234f-4230-9b49-4802a0ecc12b
pl_limit_phi = SD.plot_limit_ϕ()

# ╔═╡ 2304c10b-5408-43cb-959f-a18bbef6cbc8
pl_limit=plot(pl_pivot_Poisson,pl_limit_p,pl_limit_u,pl_limit_phi,layout=(2,2))

# ╔═╡ 46c44f40-b9dc-444d-8afb-7f41685c0a60
savefig(pl_limit,"./figs/fig_limit.pdf")

# ╔═╡ Cell order:
# ╠═8515b2c8-d3a9-11ed-10c4-b77658263370
# ╠═196443bd-913a-483a-bd57-0af0ca9f29df
# ╠═0ed771d2-d325-4c42-b7d9-333897de126e
# ╠═a1d5edf6-7cfe-4f07-b520-bad358b70876
# ╠═05db2254-1f29-4c17-8547-dfc8cec0b456
# ╟─dfbf4914-34cc-483b-94bc-dd39c6633593
# ╠═4ba3da33-2d99-4dba-9c96-6076833b5f65
# ╠═92e2b9aa-c89d-4504-ba77-bb2a82b7259e
# ╠═84e50aec-cc65-4fa4-8238-e0916fbdc9e9
# ╠═4a645257-3c19-4bad-9148-8fcbc2dd3d2b
# ╠═1d292187-b726-4306-af6b-844a3043bf4d
# ╠═9787cc02-5fc6-4ed2-8b84-d5982a6cbe9e
# ╟─c317fb8b-c845-4682-803a-540dd7af0fdb
# ╠═5b75cdcf-233f-45df-aee8-a655be1f7323
# ╠═dfb0e5f1-02b9-4ec2-9b44-2cc165cf607e
# ╠═e8d17680-c6dc-41cf-9761-79bbe0cebdc7
# ╠═616a210d-fa75-492a-8c53-67a4e1842346
# ╠═3fa8b0c7-dc5a-4a19-a5fb-79a0b56e830a
# ╠═6cddb256-2e32-473b-ad7f-8b1ce4978a62
# ╠═8aa82202-c557-448a-a392-3584f3e7df73
# ╠═83974d99-5102-4b00-b485-0562fd36ebdc
# ╠═3c37bb93-e768-4b16-84e6-4d451387f7ab
# ╠═39adac8e-9253-422a-a798-16f70634dd2d
# ╠═c8bee348-a463-46fd-8052-6ec9377280eb
# ╠═14a93dff-236f-4663-a1c2-35e664549e77
# ╠═03a503fd-f0bd-414c-ba22-a3332c578f83
# ╠═381274cb-96a0-4d5b-bffa-df199151103c
# ╠═07a7ac57-08f0-4180-9890-c069cde116e1
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
